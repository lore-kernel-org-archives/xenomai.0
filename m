Date: Tue, 11 Sep 2007 03:52:15 -0700 (PDT)
From: poornima r <rpoornar@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <747825.19128.qm@domain.hid>
Subject: [Adeos-main] Adeos to Linux domain data communication
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Hello,

I am working on PPC boards (MPC 860).
I have patched
Adeos(adeos-ipipe-2.6.18-ppc-1.5-01.patch)
to my vanilla kernel linux-2.6.18.
My requirement are 
1. A domain servicing critical interrupts and 
2. Adeos to Linux domain communication

I could implement the first requirement by creating a 
test domain where my interrupts are getting serviced
as provided in the below link
http://www.captain.at/adeos-ipipe-jitter-latency-test.php


But for the second requirement I went through all the
API services provided by Adeos but, dint find any APIs
 providing data communication services between Adeos
and Linux domains. Is there any method to implement
the above similar to pipes in Xenomai (I am not using
Xenomai in my current implementation).

But when went through Adeos related papers and
documents, I found that Adeos is mainly used for
harware sharing among multiple OSes or domains but
alone does not provide tasking, communication, etc. So
do you think     
can we implement communication mechanism similar to
xenomai pipes for Adeos domain and Linux domain
communication or is it worth using Xenomai?     

Thanks & Regards,
Poornima


      ____________________________________________________________________________________
Shape Yahoo! in your own image.  Join our Network Research Panel today!   http://surveylink.yahoo.com/gmrs/yahoo_panel_invite.asp?a=7 



