Message-ID: <455B5489.4070900@domain.hid>
Date: Wed, 15 Nov 2006 18:55:21 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] pthread_setname_np
References: <DD39B5C3F4963040ADC9768BE7E430CB0154F04D@is-hdq-exchange.marel.net>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB0154F04D@is-hdq-exchange.marel.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

Daniel Schnell wrote:
> Gilles Chanteperdrix wrote:
> 
> 
>>The problem is that we would have to store this additional
>>information in the pthread_attr_t structure. And in order to allow
>>users to include and use the Xenomai API and the native pthread API
>>at the same time, Xenomai use the same definition for all the
>>pthread_* types as the native pthread API, and we do not know if the
>>native API has room for an additional string.     
> 
> 
> Which are the space constraints here ? Do we have a fixed amount of
> bytes that maybe inside the pthread_t structure ? Is there a
> compatibility issue to older Xenomai versions ?

The pthread_attr_t structure is handled by Xenomai as an opaque type. We
do not know if there is room for an additional pointer there, and we do
not want to know it; even if there was some room in one version of the
glibc, we would not have any guarantee that this space exists in later
versions.

It is a tradeoff: handling pthread_attr_t as an opaque structure is very
convenient whereas having to use pthread_set_name_np is a minor
inconvenience.

-- 
                                                 Gilles Chanteperdrix

