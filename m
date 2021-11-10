From: "Godbille, Clement" <Clement.Godbille2@leoni.com>
Subject: Regarding the development of an OOB compatible driver
Date: Wed, 10 Nov 2021 09:21:56 +0000
Message-ID: <AM6PR08MB3416216AD62539EF2AC88688B2939@AM6PR08MB3416.eurprd08.prod.outlook.com>
Content-Language: fr-FR
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

Dear support team members,

I successfully installed the EVL core (v5.10.59) on a Raspberry pi 4 with a=
 64 bits OS, along the EVL library. EVL tests ran smoothly and I was able t=
o use its timers and witness improvements in my application for clocks and =
cyclic time.

I am now trying to turn an existing driver (amba UART pl011) into an OOB ca=
pable driver for the same application. In the open method associated with t=
his driver,  I called the evl_open_file, evl_init_wait and evl_init_poll_he=
ad methods to initialize my oob-related structure following what is done in=
 the GPIO OOB capable driver provided by EVL.

For  now I am just trying to add to its interruption the IRQF_OOB flag. It =
seems that my interruption actually becomes out-of-band compatible as the "=
oob" flag appears when I look into the /proc/interrupts file.

However I don't know what I am missing in my driver initialization, for as =
soon as the driver must handle an interrupt the OS blocks indefinitely. It =
also blocks when I remove all code in the IRQ handler with return IRQ_HANDL=
ED, but not when I return IRQ_NONE. In that case the kernel returns the mes=
sage "out-of-band irq: stuck or unexpected", which is an expected behaviour=
.

I didn't change much in the original driver so far, I didn't even create oo=
b_read, oob_write or oob_ioctl methods yet, as I suppose those steps come a=
fterwards. I only created an oob_poll method which would deal with events r=
eceived in my interruption.

I am asking you if it seems to you that I am not correctly using EVL. I mus=
t also admit that this is my very first experience with kernel development =
so I may also make inappropriate changes to my driver unrelated to EVL.

Thank you for your time and best regards.

Cl=E9ment GODBILLE
Software engineer
Business Unit Robotic Solutions

LEONI CIA Cable Systems S.A.S.
1, Avenue Louis Pasteur
28630 Gellainville
France

RCS Chartres B 330 388 356
TVA : FR 68 330 388 356
President : Peter GERSTENBERGER
General Manager : Claude BURLOT

Note importante:
Cet e-mail est strictement r=E9serv=E9 =E0 l'usage de la personne ou de l'e=
ntit=E9 =E0 qui il est adress=E9 et est susceptible de contenir des informa=
tions privil=E9gi=E9es et confidentielles. Si vous recevez ce courriel par =
erreur, vous =EAtes inform=E9 qu'il est strictement interdit de le copier o=
u de le distribuer. Merci de nous en informer imm=E9diatement et de d=E9tru=
ire la transmission originale.
Merci pour votre cooperation.

