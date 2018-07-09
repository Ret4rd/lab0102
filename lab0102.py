import numpy
import logging
import datetime

nameFile=''
rowNum = 0
colNum = 0
j = 0
matA = numpy.array([[],[]])
matB = numpy.array([])
arrCol = []
result = []
matB = []

def errorLog(strLog, Slau, res, time):
    try:
        DataBase.callFunction('set_lab0201Log', strLog, time)
        if ((Slau !=0) and (res!=0)):
            DataBase.callFunction('set_lab0201decision', Slau, res)
    except Exception as error:
        print(str(error))


from threading import Lock
import mysql.connector
class _DataBase:
    def __connect(self):
        self.__db = mysql.connector.connect(host='localhost', database='tmp', user='root', password='')
        if self.__db.is_connected():
            self.__cursor = self.__db.cursor()

    def __init__(self):
        self.__connect()
        self._mutex = Lock()

    def callFunction(self, nameFunction: str, *args):
        self._mutex.acquire()
        result = None
        try:
            if not(self.__db.is_connected()):
                self.__connect()

            self.__cursor.callproc(nameFunction, args)
            result = []

            for item in self.__cursor.stored_results():
                for item2 in item.fetchall():
                    result.append(item2)

            self.__db.commit()

        finally:
            self._mutex.release()
        return result
DataBase = _DataBase()

logging.basicConfig(format = u'"time": "%(asctime)s", "levelname": "%(levelname)s", "message": "%(message)s"', level = logging.DEBUG, filename = u'mylog.log')
nameFile = input()
time = datetime.datetime.now()
try:
    file=open(nameFile,'r')
except IOError as error:
    logging.error(str(error))
    errorLog(str(error), 0, 0, time)
    exit(0)
else:
    with file:
        matA = []
        for line in file:
            try:
                row = [float(i) for i in line.split()]
            except:
                logging.error("Ошибка чтения")
                errorLog("Ошибка чтения",0, 0, time)
                exit(4)
            matA.append(row)
            arrCol.append(len(row) - 1)
            j = 0
            while j < rowNum:
                if (arrCol[j] != len(row) - 1):
                    logging.error("Неправильный порядок матрицы")
                    errorLog("Неправильный порядок матрицы", 0, 0, time)
                    exit(2)
                j += 1
            rowNum+=1
        file.closed
#Slau = matA;
colNum = len(row)-1
if (colNum!=rowNum):
    logging.error("Неправильный порядок матрицы")
    errorLog("Неправильный порядок матрицы", 0, 0, time)
    exit(0)
for i in range(rowNum):
    matB.append(matA[i].pop())
try:
    result = numpy.linalg.solve(matA, matB)
except:
    logging.error("Деление на ноль")
    errorLog("Деление на ноль", str(matA)+str(matB), 0, time)
    exit(3)
logging.info( u'CoefficientsOfX: %s, freeCoefficients: %s, result: %s', matA, matB, result )
#logging.basicConfig(format = u'"time": "%(asctime)s", "levelname": "%(levelname)s", "message": "%(message)s"', level = logging.DEBUG);
#strLog = logging.info( u'CoefficientsOfX: %s, freeCoefficients: %s, result: %s', matA, matB, result );
strLog = 'time: ' + str(time) + ', message: CoeffOfX: '+ str(matA) + ', freeCoeff: '+ str(matB) + ', result: '+ str(result)
#try:
 #   DataBase.callFunction('set_lab0201Log', strLog)
  #  DataBase.callFunction('set_lab0201decision', str(matA)+str(matB), str(result))
#except Exception as error:
 #   print(str(error))
errorLog(strLog, str(matA)+str(matB), str(result), 0)