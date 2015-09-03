Message-ID: <d569079f4371f5efdff3486fe9c25cd9.squirrel@sourcetrek.com>
In-Reply-To: <55E7F2E7.5080007@free.fr>
References: <55E7F2E7.5080007@free.fr>
Date: Thu, 3 Sep 2015 09:22:42 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] rt_e1000e ioctls for link status
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?B?IlN0w6lwaGFuZSBBTkNFTE9UIg==?= <sancelot@free.fr>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


Stéphane ANCELOT wrote:
> Hi,
> I would need being able to know when the  link ready before using the nic
> ,
>
> I have not seen any available ioctl to do this in  this driver.
>
> Can I do this ?

Of course, simply add the ioctls you need to the driver, and make a small
tool to use these ioctls.

Regards.


-- 
                                            Gilles.
https://click-hack.org


