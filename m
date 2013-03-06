Message-ID: <5136F9E9.9030604@hilscher.com>
Date: Wed, 06 Mar 2013 09:10:17 +0100
From: Jerome Poncin <JPoncin@hilscher.com>
MIME-Version: 1.0
References: <512C806F.2020209@hilscher.com>	<512C9E78.1060208@siemens.com>	<512CC5C6.8050204@hilscher.com>	<512CC6A3.1010005@siemens.com>	<512F120A.5060109@hilscher.com>	<512F4005.60000@siemens.com>	<512F48AA.8020601@hilscher.com>	<5130B39C.70300@hilscher.com>
	<513465CF.4030807@hilscher.com>	<51350D5B.6060309@xenomai.org>
	<5135CCDE.5090401@hilscher.com>	<5135D667.8060309@siemens.com>
	<51361281.20307@hilscher.com> <51364A61.3090002@xenomai.org>
In-Reply-To: <51364A61.3090002@xenomai.org>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Hilscher driver for cifX boards
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello Gilles,

I don't understand, because I think I did a maximum of modifications=20
that you said me...

I'm agree to test the code if you fixed the code, no problem. Perhaps I=20
don't understand what you really want.

For modification in 80 line, how to change this ? :

struct pxa_dev_info *pxa_info =3D
         (struct pxa_dev_info *)((struct io_info *)info->device_data)->priv;
     uint32_t __iomem *plx_timing;

I can't do a function...

Hilscher France
12, rue du 35=E8me R=E9giment d'Aviation
Miniparc du Ch=EAne
69500 BRON
France
T=E9l. : +33 (0) 4 72 37 98 40
Fax  : +33 (0) 4 78 26 83 27
http://www.hilscher.fr
HILSCHER FRANCE 	J=E9r=F4me Poncin
jponcin@hilscher.com
Ing=E9nieur D=E9veloppement Logiciel
T=E9l. : +33 (0) 4 72 37 98 44



Le 05/03/2013 20:41, Gilles Chanteperdrix a =E9crit :
> On 03/05/2013 04:42 PM, Jerome Poncin wrote:
>
>> Hello,
>>
>> Finally, I removed #define Debug  with a little code re factoring. I
>> tested with all kernel compilation.
>> It run well, therefore I send you my last patch.
>
> Ok, I understand you are not willing to follow our recommandations.
> Would you agree to test it if we fixed your code?
>
>

