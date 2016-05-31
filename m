From: Wolfgang Netbal <wolfgang.netbal@sigmatek.at>
Message-ID: <574D9B03.8080706@sigmatek.at>
Date: Tue, 31 May 2016 16:09:07 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] Performance impact after switching from 2.6.2.1 to 2.6.4
Reply-To: wolfgang.netbal@sigmatek.at
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Dear all,

we have moved our application from "XENOMAI 2.6.2.1 + Linux 3.0.43" to 
"XENOMAI 2.6.4. + Linux 3.10.53". Our target is an i.MX6DL. The system 
is now up and running and works stable. Unfortunately we see a 
difference in the performance. Our old combination (XENOMAI 2.6.2.1 + 
Linux 3.0.43) was slightly faster.

At the moment it looks like that XENOMAI 2.6.4 calls 
xnpod_schedule_handler much more often then XENOMAI 2.6.2.1 in our old 
system.  Every call of xnpod_schedule_handler interrupts our main 
XENOMAI task with priority = 95.

I have compared the configuration of both XENOMAI versions but did not 
found any difference. I checked the source code (new commits) but did 
also not find a solution.


Any help would be greatly appreciated.

-- 
Wolfgang Netbal
Softwareentwicklung
________________________________

SIGMATEK GmbH & Co KG
Sigmatekstraße 1
5112 Lamprechtshausen
Österreich / Austria

Tel.: +43/6274/4321-0
Fax: +43/6274/4321-300
E-Mail: wolfgang.netbal@sigmatek.at
http://www.sigmatek-automation.at

****************************Please note: ****************************
This email and all attachments are confidential and intended solely
for the person or entity to whom it is addressed. If you are not the
named addressee you must not make this email and all attachments
accessible to any other person. If you have received this email in
error please delete it together with all attachments.
*********************************************************************

