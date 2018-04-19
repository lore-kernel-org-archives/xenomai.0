Message-ID: <1524146606.6529.14.camel@sprinte.eu>
From: Julien Blanc <julien.blanc@sprinte.eu>
Date: Thu, 19 Apr 2018 16:03:26 +0200
In-Reply-To: <2015698043.3051149.1524144424600.JavaMail.zimbra@etu.esisar.grenoble-inp.fr>
References: <2015698043.3051149.1524144424600.JavaMail.zimbra@etu.esisar.grenoble-inp.fr>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Call Alchemy API from a Posix skin thread
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Yann le Chevoir <yann.le-chevoir@grenoble-inp.org>, xenomai <xenomai@xenomai.org>

Le jeudi 19 avril 2018 à 15:27 +0200, Yann le Chevoir a écrit :
> 
> I thought that both Alchemy and Posix skins would create a "Xenomai
> thread"
> and so I could mix the calls to API skins.

You can mix the APIs, but not the descriptors (ie, don't
rt_mutex_acquire a pthread_mutex_t). However, it may be a wrapping
issue, which will result in your posix threads not using cobalt API,
but the linux nptl api.

Make sure your calling thread shows up in /prox/xenomai/sched/threads.
If not, check your build and linker settings. (or force the use of
cobalt api with __RT macro for your pthread* calls).

Regards,

Julien

