Subject: Re: Debian packages for Xenomai 3.x
References: <b440d689-399e-32f1-c981-c66e655d955a@alaxarxa.net>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <14f0f364-5733-deeb-370b-975462860e56@siemens.com>
Date: Tue, 6 Nov 2018 19:04:56 +0100
MIME-Version: 1.0
In-Reply-To: <b440d689-399e-32f1-c981-c66e655d955a@alaxarxa.net>
Content-Type: text/plain; charset=utf-8
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
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>, Xenomai List <xenomai@xenomai.org>, Henning Schild <henning.schild@siemens.com>

On 30.11.17 12:27, Leopold Palomo-Avellaneda wrote:
> Hi,
> 
> 
> if someone is interested I have been working a bit with the debian directory in
> xenomai3.
> 
> I have changed the approach to the libraries. I think that now it has not sense
> to have a libxenomai1 so I have changed it to xenomai3-libs.
> 
> The source, and the patches applied are here:
> 
> https://anonscm.debian.org/cgit/collab-maint/xenomai.git/
> 
> In case there's some interest, I can try to push it again to the official Debian
> repositories.
> 

Picking up this topic again:

I'm also in favor of reanimating the upstream Debian package, provided it adds
value to users. In the past, a downside was the unhandy kernel build process,
but maybe users were still happy. OTH, we may have a chance to provide binaries
at least for the standard target x86-64.

I'm currently preparing Debian-based demo and test images, generated
automatically via some "magic" (Isar image builder). For that, we will need
clean debian control files also in the Xenomai repo. That raises the question
how to keep both debian folders best in sync - if both should be used. Suggestions?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

