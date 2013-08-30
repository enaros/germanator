getNextWord = function() {
	var exponentiationBase = 3;
	var now = new Date().getTime();
	var exam = collections.findOne({
		expirationDate : { $lte : now }
	});

	if (hit) exam.interval *= exponentiationBase;
	else exam.interval /= exponentiationBase;

	exam.expirationDate = now + exam.interval * (Math.random()*0.4 -0.2);

	update(exam._id, exam);

	// basic inefficient statistics
	var date = new Date();
	var formatedNow = date.getDate() + "/" + (date.getMonth()+1) + "/" + date.getFullYear();
	statistics.wordsInMind[formatedNow] = collections.count({
		expirationDate : { $st : now}
	});
	statistics.wordsRememberedForADay[formatedNow] = collections.count({
		interval : { $gt : 24*60*60*exponentiationBase}
	});

	//las estadísticas tendrían que estar tambien en la base de datos
}