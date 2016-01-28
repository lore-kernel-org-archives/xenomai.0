Message-ID: <DUB122-W12189AD8672E553549138CC5DA0@phx.gbl>
From: Gianmarco Ottavi <ottavig@hotmail.it>
Date: Thu, 28 Jan 2016 16:19:16 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Xenomai on Raspberry Pi 2
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I'm trying to make xenomai works on Pi 2 but i get some building errors whi=
le compiling the kernel. I've looked it up online for some guide on how to =
make it works=2C tried for example https://github.com/awesomebytes/xenorasp=
=2C and seems to work and boot on Pi b+ but if i try it on Pi 2 it won't bo=
ot up(maybe becasue works only on 3.18 and newer=2C and xenorasp is on 3.10=
).The error i get while compiling for xenomai 3.0 on kernel 3.18 is:"undefi=
ned reference to '__ipipe_mach_get_tscinfo'
any idea? 		 	   		  =
