Subject: Re: RFC: making dlopen support default on for debian/rules
References: <20200120090144.1d93b807@md1za8fc.ad001.siemens.net>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <e46f7501-c7d8-0c0a-55f7-dbcee4201088@siemens.com>
Date: Tue, 21 Jan 2020 18:41:09 +0100
MIME-Version: 1.0
In-Reply-To: <20200120090144.1d93b807@md1za8fc.ad001.siemens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>, Xenomai <xenomai@xenomai.org>

On 20.01.20 09:01, Henning Schild via Xenomai wrote:
> Hi all,
> 
> i do carry a local patch to make the debian packages dlopen-aware for
> quite some time now. It used to be that debian packaging was not well
> supported and just carried for reference.
> But with the rise of Isar in the building Xenomai world the current
> view on the debian/ support might change.
> 
> What are your thoughts on putting "--enable-dlopen-libs" into
> debian/rules? I would be happy to send a patch.

I'm not really opposed to it.

The primary impact of the switch is changing the TLS model to something 
dlopen-friendly. That comes with a couple of extra instructions, maybe 
an extra cacheline need. At least for x86, the impact should be minimal. 
On weaker platforms, it might be measurable.

On the other hand, people short on cycles and sensitive to such overhead 
may do their own tuning anyway, use a custom kernel and possibly also a 
custom userland. Distro packages are about broad functionality.

Jan

