Message-ID: <A7F7E9DFC6DD4132AD68D2EE9D2A451A@pc2012PC>
From: "Marko Roganovic" <marko.roganovic@pupin.rs>
Date: Tue, 1 Jul 2014 10:30:04 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] CAN bus on beaglebone black
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Dear Xenomai users and developers,



I am relatively new to Xenomai, and we are working on a project that uses B=
eaglebone black platform (3.8.13xenomai kernel). The idea is to port our co=
de that runs on x86 platform and RTAI Linux interface, to Beaglebone black.=
 In a process we decided to switch from RTAI to Xenomai. Most of the job is=
 done relatively with no problems, but now we are facing the challenge how =
to connect our proprietary hardware to this new Beaglebone black platform. =
The idea is to use CAN bus, since it best suits real time constraints that =
we must meet. 



As I understood, in rtcan core within Xenomai, there is no support for c_ca=
n (d_can) driver which is used on Beaglebone black (we tried kernel driver =
and it worked with our hardware fine). So I am interested if someone is wor=
king on porting this driver to rtcan (or has ported it already). Any help i=
s appreciated.



Marko Roganovic





---
U ovoj e-po=B9ti nema virusa i zlonamjernih programa jer je aktivna avast! =
antivirusna za=B9tita.
http://www.avast.com
