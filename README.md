# vending_machine_part2
# Project Details
Coding language: Verilog

# Problem Description
  The vending machine contains four products. Customers can select any product and pay for it using ₹1, ₹2, ₹5, or ₹10 denominations. Any excess amount paid will be refunded to the customer.
  
# FSM Consideration 
  *The entire system is divided into two primary components: the data path and the control path.
  ## Datapath
  *The data path comprises the hardware elements necessary for constructing the overall system and the flow of data, such as subtractors, registers, and comparators.
  ![image](https://github.com/user-attachments/assets/898aaef3-1360-4be7-811a-7be4c4d1a85a)

  
  ## Controlpath
  *The control path, on the other hand, is responsible for managing the flow of signals within the system. It consists of a sequence of control signals that dictate the operation of the data path components. These control signals are generated by a control unit, which interprets the instructions provided by the system's software and determines the appropriate sequence of operations to be performed.
  
  *The interaction between the data path and the control path is crucial for the proper functioning of the entire system. The data path components perform the actual computations and data manipulations, while the control path ensures that these operations are carried out in the correct order and with the correct data. The separation of the data path and the control path makes it easier to modify the system's behavior by changing the control signals without having to modify the data path components.

  ![Uploading image.png…]()


  ## Result
  ![image](https://github.com/user-attachments/assets/726d19d0-6676-44e1-80c1-22039577a6eb)

  


