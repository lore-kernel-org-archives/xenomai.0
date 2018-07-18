References: <6cfe07fb-23f1-4dc9-7e27-c264cedd4281@alaxarxa.net>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <08914c83-8cb0-5c27-3ee9-7cef3ac5b5b8@siemens.com>
Date: Wed, 18 Jul 2018 21:33:38 +0200
MIME-Version: 1.0
In-Reply-To: <6cfe07fb-23f1-4dc9-7e27-c264cedd4281@alaxarxa.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Cards paramenter in rtnet
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 2018-07-18 13:37, Leopold Palomo-Avellaneda wrote:
> Hi,
> 
> 
> I have used the cards parameter to load a rtnet driver to select which card I
> would like to use with rtnet. However, in 3.0.7 I have found this message:
> 
> rt_e1000e: unknown parameter 'cards' ignored
> 
> Here [1], is documented the use of this parameter, so I guess that is not
> deprecated. But I have also found this unknown option for me: REBIND_RT_NICS.
> 
> So, what is the best option to load a rtnet driver and select which card do you
> want to use?

Use binding/unbinding via sysfs for that. I think we do that in the
rtnet startup script as well. That parameter dates back to the days
where this was not available (or discovered?) yet.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

