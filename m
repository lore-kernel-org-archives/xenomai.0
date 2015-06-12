Message-ID: <d51eef9efd92f7e92a345e711e39d36e.squirrel@sourcetrek.com>
In-Reply-To: <CA+K1mPFkzcYeaaUnChRRAjYMoKXxHzjjAfZtDi79zy59S8ZVSQ@mail.gmail.com>
References: <e85c77d488ea4d89e8efd14cc5d82a92.squirrel@sourcetrek.com>
 <A2E3B789-3ADD-4D70-8414-E7533CF2A6D4@mah.priv.at>
 <CA+K1mPFkzcYeaaUnChRRAjYMoKXxHzjjAfZtDi79zy59S8ZVSQ@mail.gmail.com>
Date: Fri, 12 Jun 2015 18:39:27 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Does Xenomai export shared memory keys to Linux
 kernel?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: C Smith <csmithquestions@gmail.com>
Cc: xenomai@xenomai.org


C Smith wrote:
> OK, thanks, Gilles and Michael for your explanation and suggestion.
> What I have works for now if I link my userspace app to Xenomai,though my
> goal was to stay as "standard" as possible to maintain compatibility with
> legacy POSIX code.
>
> My vote is please keep the POSIX code in Xenomai for as long as you can -
> it actually works.

The POSIX code in user-space is there to stay. What will go when Xenomai 3
is released (and that should be real soon now) is the POSIX interface in
kernel-space. In kernel-space, you should use the RTDM skin.


-- 
                    Gilles.


