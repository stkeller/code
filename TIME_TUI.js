// Javascript Document

		// Initialize Variables		
		var activeTokens = [];
		// Page turn variables
		var page = 1;
		var currentRotation = 0;
		var lastRotation = 0;
		

		var prev_issue = 6;

		// Token Class
		var maxID = 4;
		var tokenClass = [
							 // List of tokens and atributes
							 {"Id":0, "isActive":false, "tokenDict":"Decade", 		"xPos":0, "yPos":0, "rotation":0, "decade":10},
							 {"Id":1, "isActive":false, "tokenDict":"Year", 		"xPos":0, "yPos":0, "rotation":0, "year":10},
							 {"Id":2, "isActive":false, "tokenDict":"Month",		"xPos":0, "yPos":0, "rotation":0, "month":0},
							 {"Id":3, "isActive":false, "tokenDict":"Issue",		"xPos":0, "yPos":0, "rotation":0, "issue":0},
							 {"Id":4, "isActive":false, "tokenDict":"Page Scroll",	"xPos":0, "yPos":0, "rotation":0}
						 ];

		$(function() {
			var client = new Tuio.Client({
				host: "http://localhost:5000"
			}),
			screenW = $(document).width(),
			screenH = $(document).height()

			onConnect = function() {
				console.log("onConnect");
			},

			///////////////
			// Add Token //
			///////////////
			onAddTuioObject = function(addObject) {
				

				if(addObject.symbolId <= maxID){
					var tokenID = addObject.symbolId;
					var tokenX = addObject.xPos;
					var tokenY = addObject.yPos;
					var tokenRotation = addObject.angle;
					if (tokenID == 3 && tokenRotation > 0){
						tokenClass[3].rotation = 0;
					}
					console.log("Token added " + tokenID);
					
					// Update tokenClass
					tokenClass[tokenID].isActive = true;
					tokenClass[tokenID].xPos = addObject.xPos;
					tokenClass[tokenID].yPos = addObject.yPos;
					tokenClass[tokenID].rotation = addObject.angle;
					// Add Id to array
					activeTokens.push(tokenID);
					console.log(activeTokens);
					
					

					// Decade slider
					if (tokenID == 0){
						decade = Math.floor(tokenX * 10) + 192;
					}
					
					// Year slider
					if (tokenID == 1){
						year = Math.floor(tokenX * 10);
					}

					//month slider
					if (tokenID == 2){
						month = Math.floor(tokenX * 13);
					}


				// Decade slider
					if (tokenID == 0){
						decade_filter( decade, year, month );	
					} 
					
					// Year slider
					if (tokenID == 1){
						year_filter( year, decade, month );	
					}

					//month slider
					if (tokenID == 2){
						month_filter( month, decade, year );	
					} 

					// Page Turn
					if (tokenID == 3){
						//issue selection
							tokenClass[3].issue = Math.floor(tokenX * issue_list.length);
							console.log('issue = ' + tokenClass[3].issue);
							for(i=0; i<issue_list.length; i++){
								if (tokenClass[3].issue == i){
									page = 1;
									console.log(page);
									ShowImages2(issue_list[i]);
								}}

							prev_issue = tokenClass[3].issue;

						}
				}
			},

			//////////////////
			// Update Token //
			//////////////////
			onUpdateTuioObject = function(updateObject) {
				

				if(updateObject.symbolId <= maxID){
					var tokenID = updateObject.symbolId;
					var tokenX = updateObject.xPos;
					var tokenY = updateObject.yPos;
					var tokenRotation = updateObject.angle;
					
					// Update tokenClass
					tokenClass[tokenID].xPos = updateObject.xPos;
					tokenClass[tokenID].yPos = updateObject.YPos;
					tokenClass[tokenID].rotation = updateObject.angle;
					
				// Decade slider
					if (tokenID == 0){
						decade = Math.floor(tokenX * 10) + 192;
					}
					
					// Year slider
					if (tokenID == 1){
						year = Math.floor(tokenX * 10);
					}

					//month slider
					if (tokenID == 2){
						month = Math.floor(tokenX * 13);
					}


			// Decade slider
					if (tokenID == 0){
						decade_filter( decade, year, month );	
					} 
					
					// Year slider
					if (tokenID == 1){
						year_filter( year, decade, month );
					}

					//month slider
					if (tokenID == 2){
						month_filter( month, decade, year );	
					} 
					
					// Page Turn
					if (tokenID == 3){
						//issue selection
						tokenClass[3].issue = Math.floor(tokenX * issue_list.length);

						if (prev_issue!=tokenClass[3].issue){ //only update if position has changed
							HideImages();
							
							
							for(i=0; i<issue_list.length; i++){
								if (tokenClass[3].issue == i){
									ShowImages2(issue_list[i]);
									page = 1;
								}}
						}

						//page turning tracks rotation
						currentRotation = Math.floor(tokenRotation)
						if (currentRotation == 6){
							currentRotation = 0;
							lastRotation = 0;
						}
						if (currentRotation != lastRotation){							
							var direction = currentRotation - lastRotation;
							if(direction == 5){direction = -1;}
							if (direction > 0){
								page = page + 1;
								Pages(page - 1, direction);
							}
							else{
								page = page - 1;
								Pages(page + 1, direction);
							}
							
							if(page < 1 ){ page = 1; }
						
							console.log("Page = " + String(page));
						}
						lastRotation = currentRotation;
						prev_issue = tokenClass[3].issue;
					}


				}
			},

			//////////////////
			// Remove Token //
			//////////////////
			onRemoveTuioObject = function(removeObject) {
				if(removeObject.symbolId <= maxID){
					var tokenID = removeObject.symbolId;
					var tokenX = removeObject.xPos;
					var tokenY = removeObject.yPos;
					var tokenRotation = removeObject.angle;
					console.log("Token removed " + tokenID);
					
					// Update tokenClass
					tokenClass[tokenID].isActive = false;
					tokenClass[tokenID].xPos = 0;
					tokenClass[tokenID].yPos = 0;
					tokenClass[tokenID].rotation = 0;
					
					// Remove Id from array
					var index = activeTokens.indexOf(removeObject.symbolId);
					activeTokens.splice(index, 1);
					console.log(activeTokens);
					
					
					// Reset Filters
					if (tokenID == 0){
						decade= 202;
						decade_filter( decade, year, month );			
					}
					// Year slider
					if (tokenID == 1){
						year=10;
						year_filter( year, decade, month );	
					}
					// Month slider
					if (tokenID == 2){
						month =0;
						month_filter( month, decade, year);
					}

					
					// Issue selector and page turner
					if (tokenID ==3){
						HideImages();
						page = 1;
						//month_filter( tokenClass[2].month, tokenClass[0].decade + 192, tokenClass[1].year );
					}
				}
			},

			onRefresh = function(time) {
				
			};

			client.on("connect", onConnect);
			client.on("addTuioObject", onAddTuioObject);
			client.on("updateTuioObject", onUpdateTuioObject);
			client.on("removeTuioObject", onRemoveTuioObject);
			client.on("refresh", onRefresh);
			client.connect();
		});