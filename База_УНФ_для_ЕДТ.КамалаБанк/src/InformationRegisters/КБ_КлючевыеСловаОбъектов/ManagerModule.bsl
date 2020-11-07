#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда


#Область ПрограммныйИнтерфейс

// Возвращает массив объектов указанного типа, которым соответствует указанный в параметрах текст 
//
//Параметры:
//	Текст - Строка - Текст, в котором нужно найти ключевые слова
//	ТипСсылки - ОписаниеТипов - тип искомого объекта
//
// Возвращаемое значение: массив
Функция СписокОбъектовПоКлючевомуСлову(Знач Текст, ЭтоПоступление = Истина) Экспорт

 	Запрос = Новый Запрос;
	
	Запрос.УстановитьПараметр("КлючевоеСлово", Текст);
	Запрос.Текст =  
	"ВЫБРАТЬ
	|	КБ_КлючевыеСловаОбъектов.ВидОперации КАК ВидОперации,
	|	""РегистрСведений.КБ_КлючевыеСловаОбъектов"" КАК Источник
	|ИЗ
	|	РегистрСведений.КБ_КлючевыеСловаОбъектов КАК КБ_КлючевыеСловаОбъектов
	|ГДЕ
	|	&КлючевоеСлово Подобно КБ_КлючевыеСловаОбъектов.КлючевоеСлово";
	
	Возврат Запрос.Выполнить().Выгрузить();

КонецФункции

// Устанавливает соответствие между текстом (ключевым словом) и ссылкой на объект учета.
//Каждому тексту может соответствовать только один объект указанного типа
//
//Параметры:
//	Текст - ключевое слово, которое соответствует объекту
//	СсылкаНаОбъект - объект учета
//
Процедура ЗаписатьКлючевоеСловоОбъекта(Знач Текст, ВидОперации, СсылкаНаОбъект = Неопределено) Экспорт
	
	Если ПустаяСтрока(Текст) Тогда
		Возврат;
	КонецЕсли;
	
	// ИдентификаторОбъекта = ОбщегоНазначения.ИдентификаторОбъектаМетаданных(ТипЗнч(СсылкаНаОбъект));	
	
	НаборЗаписей = РегистрыСведений.КБ_КлючевыеСловаОбъектов.СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.КлючевоеСлово.Установить(Текст);
	//НаборЗаписей.Отбор.ИдентификаторОбъекта.Установить(ИдентификаторОбъекта);
	
	ЗаписьРегистра = НаборЗаписей.Добавить();
	ЗаписьРегистра.КлючевоеСлово = Текст;
	//ЗаписьРегистра.ИдентификаторОбъекта    = ИдентификаторОбъекта;
	ЗаписьРегистра.ВидОперации = ВидОперации;
	
	НаборЗаписей.Записать(Истина);
	
КонецПроцедуры

// Заполняет регистр сведений предопределенными ключевыми словами
Процедура ОбновитьКлючевыеСловаОбъектовПоУмолчанию() Экспорт
	
	Валюта = Справочники.Валюты.НайтиПоКоду("980");
	Если ЗначениеЗаполнено(Валюта) Тогда
		ЗаписатьКлючевоеСловоОбъекта("грн", Валюта);
		ЗаписатьКлючевоеСловоОбъекта("Гривна", Валюта);
	КонецЕсли;
	
КонецПроцедуры


#КонецОбласти


#Область ОбработчикиСобытий



#КонецОбласти

#КонецЕсли

