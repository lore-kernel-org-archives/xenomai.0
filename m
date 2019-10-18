Subject: Re: [PATCH] lib/copperplate: heapobj: catch invalid array-type init
 request
References: <20191018081555.9690-1-rpm@xenomai.org>
 <f65f579c-bb8a-febe-702b-e5fa4a2699b6@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <a2a2b7de-c2e0-807e-f17f-b794705e8bf7@xenomai.org>
Date: Fri, 18 Oct 2019 11:35:50 +0200
MIME-Version: 1.0
In-Reply-To: <f65f579c-bb8a-febe-702b-e5fa4a2699b6@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On 10/18/19 11:26 AM, Jan Kiszka wrote:
> On 18.10.19 10:15, Philippe Gerum via Xenomai wrote:
>> Setting up a zero-size, zero-element array makes no sense with this
>> interface. Catch this early on, bailing out with -EINVAL.
> 
> May I assume you wanted to sign this off?
> 

If we all agree on this, yes.

-- 
Philippe.

