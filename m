Message-ID: <533C3622.1030601@xenomai.org>
Date: Wed, 02 Apr 2014 18:09:06 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <533C32E3.3090309@steinkuehler.net>
In-Reply-To: <533C32E3.3090309@steinkuehler.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Debian Package Building Broken
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Charles Steinkuehler <charles@steinkuehler.net>
Cc: xenomai@xenomai.org

On 04/02/2014 05:55 PM, Charles Steinkuehler wrote:
> While following the instructions to build a Debian package from git:
>
> http://xenomai.org/index.php/Building_Debian_packages
>
> ...I ran into a problem.  There is a "configure" file in the git
> repository that looks like it shouldn't be there.  The build scripts
> delete this file, then complain that the local working copy has
> modifications and refuse to build the package.
>
> I was able to work around this by just deleting the configure file and
> committing the changes, but you might want to do this upstream as well.
>
> I am building from the 2.6.3 tag, but the configure file still exists in
> master:
>
> http://git.xenomai.org/xenomai-2.6.git/tree/
>
Does this still happen if you remove the line "autoreconf -fi" from 
debian/rules ?

-- 
					    Gilles.

