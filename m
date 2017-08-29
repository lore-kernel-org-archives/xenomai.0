References: <20170808112357.0063d74d@md1em3qc>
 <a676257d-9e88-1b81-15e6-adfffc1c7716@xenomai.org>
 <20170808134801.59ae5de6@md1em3qc>
 <86562178-3b5a-55fc-8652-dc15f228e541@xenomai.org>
 <20170808212758.550caab0@md1em3qc>
 <bf9689d1-3373-ad65-97df-a67fa639c6c3@xenomai.org>
 <20170825191604.723abf24@md1em3qc>
 <553cc0c2-2ce4-5182-b6eb-4a18ccad82b5@xenomai.org>
 <20170829142726.23ea20ef@md1em3qc>
 <445755f9-7406-98e9-7e2f-e30b4a6237b2@xenomai.org>
 <20170829192018.19f2ede9@md1em3qc>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <46f175d1-0b72-9b94-2543-161bbbdb401f@xenomai.org>
Date: Tue, 29 Aug 2017 22:02:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170829192018.19f2ede9@md1em3qc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [RFC] Xenomai3 tuneables replaced by environment
	variables
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>
Cc: "KISZKA, JAN" <jan.kiszka@siemens.com>, xenomai@xenomai.org

On 08/29/2017 07:20 PM, Henning Schild wrote:
> I do not mind changing the customers software to address the issue
> there. The whole thread was about making xenomai simpler, inspired by
> having to look deeper into the settings/tuneables.
> The fact that we had to talk about it for so long could indicate that
> the whole thing is not so simple.
> 

Don't you want to get a stab at the proposal to turn all Xenomai
parameters found in setup descriptors to potential/possible environment
variables?

I believe that this would fit your bill, without causing any regression
to other existing applications that may already depend on the tuning
mechanism. That seems to be a fair deal to me.

-- 
Philippe.

