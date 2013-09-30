From: Antoine MOREL <A.MOREL@polysoude.com>
Date: Mon, 30 Sep 2013 09:47:16 +0000
Message-ID: <8ceffc54095e43d88f6dfa0edd0bb852@DBXPR03MB093.eurprd03.prod.outlook.com>
Content-Language: fr-FR
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] No GPIO IRQ on imx28(apf28), kernel 3.8.13
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi all,

I'm testing Xenomai on an apf28 board, with imx28 processor.
I'm using a 3.8.13 kernel with the last Xenomai-head repositorie.

When I use the kernel without xenomai, my GPIO irq works well. But when I p=
atch my kernel with adeos and Xenomai, my gpio IRQ doesn't work!
I have the same problem with the kernel 3.4.6.

I test the gpio IRQ in user space and with RTDM driver.
Do I forget anything?

Cordialement,

Antoine MOREL
POLYSOUDE SAS
D=E9veloppement logiciel
+33(0)2 40 68 57 71

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: interrupt_xeno_kernel.c
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130930/8e334a7=
9/attachment.c>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: main.c
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130930/8e334a7=
9/attachment-0001.c>
