Message-ID: <54284361.3080403@xenomai.org>
Date: Sun, 28 Sep 2014 19:20:33 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CALe7ZU3shAd1y2yWjEgnSJjHkVOmJ5o5bfd3P+Xpm04+oNMhdg@mail.gmail.com>
In-Reply-To: <CALe7ZU3shAd1y2yWjEgnSJjHkVOmJ5o5bfd3P+Xpm04+oNMhdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] passing SMI parameter in kernel command line
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: JAY KOTHARI <jaikothari10@gmail.com>, xenomai <xenomai@xenomai.org>

On 09/28/2014 05:23 AM, JAY KOTHARI wrote:
> Sir,
>      In troubleshooting guide I have read to pass xenomai.smi=1
> in parameter to kernel command line.
>      I am not able to get kernel command line.
> 
> What I tried
> 1)to pass this parameter at boot time.

Yes, that is what "passing a parameter to kernel command line means".

> 2)I tried to change parameter in:
>          sys/module/xeno_hal/parameters

Xenomai 3 does not have a xeno_hal module, so I guess you are not using
Xenomai 2.x, in which case you misread the troubleshooting guide.

-- 
                                                                Gilles.

