From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain
Message-Id: <1069320754.626.47.camel@domain.hid>
Mime-Version: 1.0
Date: 20 Nov 2003 10:32:34 +0100
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] Adeos r9
List-Id: <adeos-main.nongnu.org>
List-Unsubscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.gnu.org/pipermail/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Hi,

Adeos r9 for 2.4 is out. Most of the work was aimed at making the
integration of Adeos with other patches easier (i.e. kpreempt,
low-latency, LTT), in order to produce combo patches later.

Adeos support for 2.6 is making progress too, and has been updated for
-test9.

Adeos patches are available here:
http://savannah.gnu.org/download/adeos/linux/

Preliminary porting doc:
http://savannah.gnu.org/download/adeos/doc/porting.txt

Some additional information about interrupt handling using Adeos in a
real-world application:
https://mail.rtai.org/pipermail/rtai/2003-November/005623.html

-- 
Philippe.



