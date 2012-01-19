Message-ID: <4F17EDAD.5030602@domain.hid>
Date: Thu, 19 Jan 2012 11:17:17 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F0B530A.80905@domain.hid>	<4F0C5524.9020501@domain.hid>	<4F0C58B7.1080602@domain.hid>	<4F0C5C00.3060508@domain.hid>	<4F0C5C02.50308@domain.hid>	<4F0C5C63.40105@domain.hid>	<4F0C5E85.5080004@domain.hid>	<4F0C7EAE.8080209@domain.hid>	<4F0C85E2.1070109@domain.hid>
	<4F0C8D0F.3080207@domain.hid> <4F174AA3.7030309@domain.hid>
In-Reply-To: <4F174AA3.7030309@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Issue with Auto relax and nested mutexes
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Makarand Pradhan <makarandpradhan@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 01/18/2012 11:41 PM, Makarand Pradhan wrote:
> Hi,
> 
> Another problem was encountered with rescnt related to nested mutexes.
> 
> This time the rescnt is not incrementing because the XNOTHER bit is not 
> set, causing a SIGDEBUG or SIGXCPU to be delivered to the thread causing 
> my application to crash.

That is deliberate. We explicitely decided to not support such case and
volontarily send a SIGDEBUG when it happens, in order to signal do that
you are doing an unsupported operation.

Can you show us a scenario where there is no other solution than
changing priority while holding a mutex?

-- 
					    Gilles.

