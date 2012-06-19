Message-ID: <4FE03D17.3040408@grandegger.com>
Date: Tue, 19 Jun 2012 10:49:27 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
References: <4FE03797.7000408@grandegger.com> <4FE03955.60108@xenomai.org>
In-Reply-To: <4FE03955.60108@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Sharing memory between rt-posix and standard-posix
 apps
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai@xenomai.org

On 06/19/2012 10:33 AM, Gilles Chanteperdrix wrote:
> On 06/19/2012 10:25 AM, Wolfgang Grandegger wrote:
>> Hello,
>>
>> the shared memory support of Xenomai's POSIX skin currently only support
>> shared memory between rt processes.
> 
> These services are for sharing memory between user-space and
> kernel-space. In order to share memory between user-space processes, you
> can use plain linux shared memories.

But then I will get mode switches due to page faults, right?

Wolfgang.



