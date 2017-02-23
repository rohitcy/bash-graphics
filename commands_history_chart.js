var initChart = function(){
    var commandsHistory;
    var chartData = getFormattedChartData(commandsHistory);

    Highcharts.chart('container', {
    chart: {
        plotBackgroundColor: null,
        plotBorderWidth: null,
        plotShadow: false,
        type: 'pie'
    },
    title: {
        text: 'Hola Senor here is your command history.'
    },
    tooltip: {
         format: '<b>{point.name}</b>: {point.percentage:.1f} %',
    },
    plotOptions: {
        pie: {
            allowPointSelect: true,
            cursor: 'pointer',
            dataLabels: {
                enabled: true,
                format: '<b>{point.name}</b>: {point.y}',
                style: {
                    color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                }
            }
        }
    },
    series: [{
                name: 'Count',
                colorByPoint: true,
                data: chartData
            }],
    size: 500
});
};

var getFormattedChartData = function(commandsHistory) {
    var name = Array();
    var data = Array();
    var chartData = Array();

    for(i = 0; i < commandsHistory.length; i++) {
       name[i] = commandsHistory[i].name;
       data[i] = commandsHistory[i].count;
    }
    for(j = 0; j < name.length; j++) {
       var formattedData = new Array(name[j],data[j]);
       chartData[j] = formattedData;
    }

    return chartData;
}
