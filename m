Message-ID: <53D78CDB.80304@xenomai.org>
Date: Tue, 29 Jul 2014 14:00:27 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <07fa8167a92741288291537ce8719ca3@CVEX13.valentin-carl.de>
In-Reply-To: <07fa8167a92741288291537ce8719ca3@CVEX13.valentin-carl.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Little fault in installation instructions for arm
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Reitinger, Peter" <preitinger@carl-valentin.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/29/2014 11:58 AM, Reitinger, Peter wrote:
> Dear xenomai people,
> 
> in README.INSTALL 3.4 Building for ARM, it is:
> $xenomai_root/configure CFLAGS="-march=armv4t" LDFLAGS="-march=armv4t" \
>   --build=i686-pc-linux-gnu --host=arm-none-linux-gnueabi-
> 
> But probably it should be ... --host=arm-none-linux-gnueabi instead? (without trailing "-")

Indeed, will fix, thanks.

-- 
                                                                Gilles.

