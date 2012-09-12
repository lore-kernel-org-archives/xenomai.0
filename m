MIME-Version: 1.0
Message-ID: <OF88348236.1046CAF7-ONC1257A77.002D5DEF-C1257A77.002DB549@LocalDomain>
Date: Wed, 12 Sep 2012 10:19:14 +0200
From: Pierre.QUELIN@solystic.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] posix skin pthread_create issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


Dear all,

I have an application that is working fine with the standard Linux kernel
API and don't works if I build it with Xenomai API.

I have a strange issue. At the begining, the application creates 28 threads
and all the 33 next returns an error. pthread=5Fcreate() returns 12 (ENOMEM=
).

I'm not sure to understand which memory is missing.

To solve this I have try :

1) to fix the pthread stack size at PTHREAD=5FSTACK=5FMIN.
=3D>without effect

2) to change the RealTime sub-system options
I increase the number of registry slots from 512 to 1024
I increase the size of the system heap from 256 to 1024
I increase the size of the private stack pool from 128 to 512
=3D>without effect

Could you please help me.

Best regards

Pierre Quelin
Ce message et toutes les pi=E8ces jointes (ci-apr=E8s le "Message") sont co=
nfidentiels et =E9tablis =E0 l'intention exclusive de leurs destinataires. =
Si vous avez re=E7u le Message par erreur, merci de l'indiquer =E0 son exp=
=E9diteur par retour et de proc=E9der =E0 sa destruction dans vos syst=E8me=
s.Toute utilisation ou diffusion de son contenu non autoris=E9e est stricte=
ment interdite. Tout message =E9lectronique est susceptible d'alt=E9ration.=
 SOLYSTIC d=E9cline toute responsabilit=E9 au titre du Message s'il a =E9t=
=E9 alt=E9r=E9, d=E9form=E9 ou falsifi=E9. SOLYSTIC ne saurait =EAtre tenue=
 pour responsable, ni de la transmission erron=E9e ou incompl=E8te des info=
rmations contenues dans ce message, ni des d=E9lais de r=E9ception ou des d=
ommages caus=E9s =E0 votre syst=E8me. SOLYSTIC ne garantit, ni que l'int=E9=
grit=E9 de la communication ait =E9t=E9 maintenue, ni que cette transmissio=
n est exempte de virus, d'interceptions ou d'interf=E9rences.

This message and any attachments (the "Message") are confidential and inten=
ded solely for the addressee(s). Any unauthorised use or dissemination of t=
he Message is strictly prohibited. E-mails are susceptible to alteration. S=
OLYSTIC shall not be liable for the Message if altered, changed or falsifie=
d. SOLYSTIC shall not be liable for the improper or incomplete transmission=
 of the information contained in the Message nor for any delay in its recei=
pt or damage to your system. SOLYSTIC does neither guarantee that the integ=
rity of the Message has been maintained, nor that this communication is fre=
e of viruses, interceptions or interferences.
