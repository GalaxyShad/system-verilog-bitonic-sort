try:
    import serial
except ImportError:
    from sys import executable as python_path
    
    raise ImportError("PySerial для работы UDM не найден. Установите библиотеку pyserial\n\n" +
                      f"pip install pyserial\n" 
                      "или\n"
                      f"{python_path} -m pip install pyserial\n"
                      "или\n"
                      f"{python_path} -m pip install pyserial --break-system-packages --user\n\n")

from activecore.designs.rtl.udm.sw.udm import *
