Message-ID: <46825ED0.8050206@domain.hid>
Date: Wed, 27 Jun 2007 14:57:52 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <468254DC.1000603@domain.hid>
	<2ff1a98a0706270528h7db4576u23f4910586207263@domain.hid>
In-Reply-To: <2ff1a98a0706270528h7db4576u23f4910586207263@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Todays trunk does not built for 2.4
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

Hi Gilles,

Gilles Chanteperdrix wrote:
> On 6/27/07, Wolfgang Grandegger <wg@domain.hid> wrote:
>> Hello,
>>
>> building Linux 2.4.25 for PPC with todays Xenomai's SVN trunk fails as
>> shown in the attachment, apart from some warnings "implicit declaration
>> of function `xnarch_*_host_mem'" . Any idea why?
> 
> I look at the declaration and implementation of pse51_desc_create in a
> freshly checked out tree and they have the same prototype. Are you
> sure your tree is not half updated ? The warning about
> xnarch_*_host_mem suggests the same thing.

Stupid me, sorry. Preparing and making a fresh kernel fix the problem. I 
used --forcelink and thought it's sane.

Wolfgang.


