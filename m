References: <2015698043.3051149.1524144424600.JavaMail.zimbra@etu.esisar.grenoble-inp.fr>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <8240d384-ca98-f787-a92f-f3a6942cb6db@xenomai.org>
Date: Thu, 19 Apr 2018 17:01:34 +0200
MIME-Version: 1.0
In-Reply-To: <2015698043.3051149.1524144424600.JavaMail.zimbra@etu.esisar.grenoble-inp.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

On 04/19/2018 03:27 PM, Yann le Chevoir wrote:
> Hello,
> 
> With Xenomai 3, I understood that all skins are based on Posix skin,
> right?
> 
> I used to use Posix skin.
> I have a third party Alchemy API (I am wondering if it was well ported
> from Native to Alchemy or not...).
> 
> Why can not I call this API from my Posix skin? Is it an expected
> behavior?

Because some services from non-POSIX APIs may need to track some bits of
API-specific context in per-thread data, and such data is only defined
for threads started by the API's thread init call, e.g.
rt_task_create(), rt_task_shadow() must have started a thread, for the
latter to be allowed to call rt_mutex_acquire().

Those services are the one failing in cross-API calls. Some of them
might be reimplemented in a way that would allow cross-API calls, by
dropping the requirement to access such per-API, per-thread data.
Interesting issue to dig for somebody who would like to get familiar
with the implementation of the Xenomai APIs and contribute.

> Given an example, I have an EPERM error when the third party API calls
> a rt_mutex_acquire from my Posix (Xenomai) thread.
> 
> I thought that both Alchemy and Posix skins would create a "Xenomai thread"
> and so I could mix the calls to API skins.
> If not, I can understand too...
> 
> Thank you for letting me know about this.
> Perhaps I just have to call an Alchemy Init function from my Posix thread?
> It could be a solution.

Calling rt_task_shadow() over an existing Cobalt POSIX thread context
would work, enabling cross-API calls for that thread.

-- 
Philippe.

