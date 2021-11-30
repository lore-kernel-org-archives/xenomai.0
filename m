From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
MIME-Version: 1.0
Date: Tue, 30 Nov 2021 14:28:53 +0100
Subject: IRQ not raised switching from =?utf-8?q?4=2E4=2Ex?= to 
 =?utf-8?q?4=2E19=2Ex?=
Message-ID: <d25-61a62700-27-1ed4ee4@258913418>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I'm experiencing a weird issue while transitioning Xenomai 3.1 from lin=
ux 4.4 to 4.19.
Platform is Zynq 7000 ARM Cortex A9.
Using the exact same hardware, porting a network device driver, the int=
errupts that should trigger whenever a packet is sent or received do no=
t grif any more. I can see the network packets being sent & received by=
 devmem'ing to the device memory and buffers, but no interrupt ever hap=
pens.

I checked the various GIC registers, and everything seems to be OK.

Any idea ?

Thanks in advance

Fran=C3=A7ois


