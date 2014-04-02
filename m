Message-ID: <533C3753.6050109@xenomai.org>
Date: Wed, 02 Apr 2014 18:14:11 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <533C32E3.3090309@steinkuehler.net> <533C348F.3010801@xenomai.org>
 <533C36F8.6030800@steinkuehler.net>
In-Reply-To: <533C36F8.6030800@steinkuehler.net>
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
To: Charles Steinkuehler <charles@steinkuehler.net>
Cc: xenomai@xenomai.org

On 04/02/2014 06:12 PM, Charles Steinkuehler wrote:
> On 4/2/2014 11:02 AM, Gilles Chanteperdrix wrote:
>> On 04/02/2014 05:55 PM, Charles Steinkuehler wrote:
>>>
>>> I am building from the 2.6.3 tag, but the configure file still exists in
>>> master:
>>>
>>> http://git.xenomai.org/xenomai-2.6.git/tree/
>>
>> No, the configure file is in the tree, this is intentional, this avoids
>> requiring people which compile the package from the git tree to have the
>> autotools installed. If debian/rules does not support that, it should be
>> fixed to support it.
> 
> I'm not sure if debian/rules allows that or not...I'm just trying to
> build 2.6.3 packages from git following the directions on the wiki:
> 
> http://xenomai.org/index.php/Building_Debian_packages#from_a_Git_repository
> 
> ...mostly because for some reason Debian doesn't build the armhf flavor
> of the Xenomai packages:
> 
> https://packages.debian.org/sid/xenomai-runtime
> 
> ...there's armel, but no armhf.  :(
> 


This is a known issue, which has been fixed in xenomai git:

http://git.xenomai.org/xenomai-2.6.git/commit/?id=b10527ed14399a6485f69b935988d9d5211066d0

You will not have it when building from the 2.6.3 tag, though.

-- 
					    Gilles.

