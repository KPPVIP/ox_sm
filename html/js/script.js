$(function(){
	window.addEventListener('message', function(event) {
		if(event.data.showhud == true){
			$('.huds').fadeIn();
			setProgressSpeed(event.data.speed,'.progress-speed');
		}
		if (event.data.action == "toggleCar"){
			if (event.data.show){
				$('.carStats').fadeIn();
			} else{
				$('.carStats').fadeOut();
			}
		} else if (event.data.action == "engineSwitch"){
            if(event.data.status){
                $('#Ellipse_5').css('fill','rgba(75,255,0,1)');
            }else{
                $('#Ellipse_5').css('fill','rgba(216,66,66,1)'); 
            }
		} else if (event.data.action == "lockSwitch"){
            if(event.data.status){
              $('#Ellipse_6').css('fill','rgba(216,66,66,1)');
				        
            }else{
              $('#Ellipse_6').css('fill','rgba(75,255,0,1)');
            }
		} else if (event.data.action == "updateGas"){
            setProgressFuel(event.data.value,'.progress-fuel');
		}
	});

});

function setProgressSpeed(value, element){
    var circle = document.querySelector(element);
    var radius = circle.r.baseVal.value;
    var circumference = radius * 2 * Math.PI;
    var html = $(element).parent().parent().find('span');
    var percent = value*100/220;

    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = `${circumference}`;


    const offset = circumference - ((-percent*73)/100) / 100 * circumference;
    circle.style.strokeDashoffset = -offset;
	
    var predkosc = Math.floor(value * 1.8)
    if (predkosc == 81 || predkosc == 131) {
      predkosc = predkosc - 1
    }
    
	html.text(predkosc);
  }

  function setProgressFuel(percent, element){

    document.getElementById('fueltext').innerHTML = percent + " L";
  }