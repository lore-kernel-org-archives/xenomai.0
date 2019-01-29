From: "Baur, Elias" <st153286@stud.uni-stuttgart.de>
Subject: Help on porting lwIP to Xenomai (Beaglebone Black, AM335X)
Date: Tue, 29 Jan 2019 09:57:56 +0000
Message-ID: <acee54530584479b865ccefdbe3b0913@stud.uni-stuttgart.de>
Content-Language: de-DE
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello everyone,

I am new to lwIP and did a lot of research the last couple of days. My goal=
 ist to do real time networking between wire-connected Beagleboards. Theref=
ore, we have been setting up a Xenomai Co-Kernel on the boards. To actually=
 send and receive UDP-packets, we want to use lwIP instead of RTnet, becaus=
e we are already using it on other boards.

I have found out that TI has already ported lwIP on its CPU in its Starterw=
are: http://processors.wiki.ti.com/index.php/StarterWare_CPSW_Port_lwIP Now=
 I am wondering whether it is possible to adapt this for Xenomai? Does anyo=
ne have experience on that?

Thank you very much!
Best, Eloa
