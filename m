Message-ID: <533C36F8.6030800@steinkuehler.net>
Date: Wed, 02 Apr 2014 11:12:40 -0500
From: Charles Steinkuehler <charles@steinkuehler.net>
MIME-Version: 1.0
References: <533C32E3.3090309@steinkuehler.net> <533C348F.3010801@xenomai.org>
In-Reply-To: <533C348F.3010801@xenomai.org>
Content-Type: text/plain; charset=UTF-8
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 4/2/2014 11:02 AM, Gilles Chanteperdrix wrote:
> On 04/02/2014 05:55 PM, Charles Steinkuehler wrote:
>>
>> I am building from the 2.6.3 tag, but the configure file still exists in
>> master:
>>
>> http://git.xenomai.org/xenomai-2.6.git/tree/
> 
> No, the configure file is in the tree, this is intentional, this avoids
> requiring people which compile the package from the git tree to have the
> autotools installed. If debian/rules does not support that, it should be
> fixed to support it.

I'm not sure if debian/rules allows that or not...I'm just trying to
build 2.6.3 packages from git following the directions on the wiki:

http://xenomai.org/index.php/Building_Debian_packages#from_a_Git_repository

...mostly because for some reason Debian doesn't build the armhf flavor
of the Xenomai packages:

https://packages.debian.org/sid/xenomai-runtime

...there's armel, but no armhf.  :(

-- 
Charles Steinkuehler
charles@steinkuehler.net

