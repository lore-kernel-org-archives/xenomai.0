Message-ID: <565DB393.3080607@goetting.de>
Date: Tue, 01 Dec 2015 15:49:55 +0100
From: Julio Cesar Aguilar Zerpa <aguilar@goetting.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] delayed or discarded ethernet packets
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello there,

State:
I am using xenomai 2.6.1.
I installed the driver of a 3D camera which transmit its data via 
ethernet (UDP).

Problem:
The transmission is being delayed (or packages are getting discarded) by 
xenomai (probably, since the problem does not appear with
a normal linux kernel).

Solution(s):
     - There seems to be a way of "pipelining" the data from the camera 
to a real time thread or
       to create a real time shared memory heap where the data is 
delivered by the camera (as a 'producer') and gotten by a 'consumer'.
     - What about increasing the priority of the ethernet interface to 
that of a real time IO thread (or similar)?

Question(s):
     - Are these two options even correct?  Are there other alternatives?
       Could you provide some example code of  the 'producer' and 
'consumer'?
       Do I need to write my own camera driver and include this 
'pipelining' or 'heap'?
     - Is there a way to increase the priority of an ethernet interface 
in xenomai?

Thank you and best regards,
Julio Aguilar

Mit freundlichen Grüßen
Götting KG
i.A. Julio Cesar Aguilar Zerpa
-- 
M.Sc. Julio Cesar Aguilar Zerpa
Forschung & Entwicklung
aguilar@goetting.de
Tel. +49(0)-5136-8096-39
————————————————————
Götting KG
Celler Str. 5, D-31275 Lehrte/Röddensen
Geschäftsführer H.-H. Götting
HR A 31127 | Amtsgericht Hildesheim
Gerichtsstand Lehrte
USt.-Id. Nr. DE 115055039
USt.-Nr. 16-226-13403
Phone +49(0)-5136-8096-0
Fax +49(0)-5136-8096-80
info@goetting.de | www.goetting.de
————————————————————


