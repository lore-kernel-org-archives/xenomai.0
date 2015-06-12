Message-ID: <557B0CBF.7080200@xenomai.org>
Date: Fri, 12 Jun 2015 18:45:51 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <e85c77d488ea4d89e8efd14cc5d82a92.squirrel@sourcetrek.com>
 <A2E3B789-3ADD-4D70-8414-E7533CF2A6D4@mah.priv.at>
 <CA+K1mPFkzcYeaaUnChRRAjYMoKXxHzjjAfZtDi79zy59S8ZVSQ@mail.gmail.com>
In-Reply-To: <CA+K1mPFkzcYeaaUnChRRAjYMoKXxHzjjAfZtDi79zy59S8ZVSQ@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
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
To: C Smith <csmithquestions@gmail.com>, Xenomai@xenomai.org

On 06/12/2015 06:23 PM, C Smith wrote:
> OK, thanks, Gilles and Michael for your explanation and suggestion.
> What I have works for now if I link my userspace app to Xenomai,though my
> goal was to stay as "standard" as possible to maintain compatibility with
> legacy POSIX code.
> 
> My vote is please keep the POSIX code in Xenomai for as long as you can -
> it actually works.
> 

POSIX support (in userland) is fundamental in Xenomai 3. All the rest
depends on it.

-- 
Philippe.

