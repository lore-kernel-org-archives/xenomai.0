Message-ID: <4F68EA11.30109@domain.hid>
Date: Tue, 20 Mar 2012 21:35:29 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CB8E2B24.1EE49%glen@domain.hid> <4F68DCBE.407@domain.hid>
	<97158F69-0343-4FA2-846B-7DE2563595A8@domain.hid>
In-Reply-To: <97158F69-0343-4FA2-846B-7DE2563595A8@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Linux Serial Does not work with
 CONFIG_XENO_OPT_PERVASIVE enabled
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Glen Wernersbach <glen@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/20/2012 09:19 PM, Glen Wernersbach wrote:
> I actually think in is in the settings because if run just the setup part of the code without reading and writing, on the kernel that works my activity LED turns off. 
> 
> On the xeno kernel the LED never changes.

I actually think that CONFIG_XENO_OPT_PERVASIVE does not make any
difference which could cause a difference of hardware behaviour. So, it
must be another option triggered by this config change. So, if you want
us to help you, please post the .configs.


-- 
                                                                Gilles.

