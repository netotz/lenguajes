package Ejemplo

import java.text.SimpleDateFormat
import java.util.TimeZone
import java.util.TimeZone.getAvailableIDs

object Demo {
  def isLeap(year: Int): Boolean ={
    year % 4 == 0 && ( year % 400 == 0 || !( year % 100 == 0 ) )
  }

  def mesesDias(year: Int): Array[Int] ={
    val meses = new Array[Int](12)
    var bool = true
    for(i <- 0 until 12){
      if(i == 1){
        if( isLeap(year) )
          meses(i) = 29
        else
          meses(i) = 28
      }
      else{
        if(i == 7)
          bool = !bool

        if(bool)
          meses(i) = 31
        else
          meses(i) = 30
      }
      bool = !bool
    }

    meses
  }

  def contar(fecha: Array[Int]): Long = {
    var dias = 0
    for (year <- (fecha(0) - 1 to 1) by -1) {
      if( isLeap(year) )
        dias += 366
      else
        dias += 365
    }

    val meses = mesesDias(fecha(0))
    for (mes <- 0 until fecha(1) - 1)
      dias += meses(mes)

    dias += fecha(2) - 1

    var horas = dias*24
    horas += fecha(3)

    var min = horas*60
    min += fecha(4)

    var seg = min*60
    seg += fecha(5)

    seg
  }

  def validPosInt(buff: String): Boolean ={
    try{
      buff.toInt
    }
    catch{
      case e: Exception => return false
    }

    if(buff.toInt < 0)
      false
    else
      true
  }

  def pedirFecha(txt: String): Array[Int] ={
    println("")
    var num = ""

    var bool = true
    while(bool){
      num = scala.io.StdIn.readLine("Ingresar año " + txt + ": ")
      if(validPosInt(num) && num.toInt > 0)
        bool = false
      else
        println("\tSolo años de la era común (después de Cristo).\n")
    }
    val year = num.toInt

    bool = true
    while(bool){
      num = scala.io.StdIn.readLine("Ingresar número de mes " + txt + ": ")
      if(validPosInt(num) && num.toInt > 0 && num.toInt < 13)
        bool = false
      else
        println("\tMes no válido.\n")
    }
    val mes = num.toInt

    bool = true
    val meses = mesesDias(year)
    while(bool){
      num = scala.io.StdIn.readLine("Ingresar día del mes " + txt + ": ")
      if(validPosInt(num) && num.toInt > 0){
        if(num.toInt <= meses(mes - 1) )
          bool = false
        else
          println("\tEl mes que ingresó solo tiene " + meses(mes  - 1) + " días.\n")
      }
      else
        println("\tEntrada no válida.\n")
    }
    val dia = num.toInt

    bool = true
    while(bool){
      num = scala.io.StdIn.readLine("Ingresar hora del día " + txt + " en formato 24 horas: ")
      if(validPosInt(num) && num.toInt < 24)
        bool = false
      else
        println("\tEntrada no válida.\n")
    }
    val hora = num.toInt

    bool = true
    while(bool){
      num = scala.io.StdIn.readLine("Ingresar minuto de la hora " + txt + ": ")
      if(validPosInt(num) && num.toInt < 60)
        bool = false
      else
        println("\tEntrada no válida.\n")
    }
    val min = num.toInt

    bool = true
    while(bool){
      num = scala.io.StdIn.readLine("Ingresar segundo del minuto " + txt + ": ")
      if(validPosInt(num) && num.toInt < 60)
        bool = false
      else
        println("\tEntrada no válida.\n")
    }
    val seg = num.toInt

    Array(year, mes, dia, hora, min, seg)
  }

  def pedirZona(txt: String): String ={
    val zonas = getAvailableIDs

    var zona = ""
    do zona = scala.io.StdIn.readLine("Ingresar zona horaria " + txt + " (nombre en inglés): ") while(zona == "")

    val regexp = ("(?i)" + zona.replaceAll(" ", "_") ).r

    zona = ""
    var contador = 0
    for(i <- zonas){
      val x = regexp findFirstIn i
      if(x.isDefined){
        zona = i
        contador += 1
      }
      if(contador > 1){
        println("\tSe encontró más de una coincidencia: por favor, sea más específico.")
        return ""
      }
    }
    if(zona == "") println("\tNo se encontraron coincidencias.")
    zona
  }

  def main(args: Array[String]): Unit ={
    val formatter = new SimpleDateFormat("yyyy MM dd HH mm ss")

    var zi = ""
    do zi = pedirZona("de nacimiento") while(zi == "")
    println("\tHa escogido " + zi)
    formatter.setTimeZone(TimeZone getTimeZone zi)

    var zf = ""
    do zf = pedirZona("actual") while(zf == "")
    println("\tHa escogido " + zf)

    var seg: Long = 0
    do{
      var ini = pedirFecha("de nacimiento")

      var str = ""
      for(i <- 0 until 6){
        str += ini(i)
        if(i != 5) str += " "
      }
      val fecha = formatter parse str
      formatter.setTimeZone(TimeZone getTimeZone zf)

      ini = (formatter format fecha).split(" ").map(_.toInt)

      val fin = pedirFecha("actual")

      seg = contar(fin) - contar(ini)
      if(seg <= 0) println("\tLas fechas no concuerdan.\n")
    }
    while(seg <= 0)

    val min = seg/60.0
    val hora = min/60
    val dia = hora/24
    println("\nHa vivido:")
    println("\t" + dia.toInt + " días con " + (hora%24).toInt + " horas, " + (min%60).toInt + " minutos y " + (seg%60).toInt + " segundos.")
    println("\t" + dia + " días en total.")
    println("\t" + hora + " horas en total.")
    println("\t" + min + " minutos en total.")
    println("\t" + seg + " segundos en total.")
  }
}