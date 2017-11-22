References: <abf31608-ffa8-17e0-e3eb-4d62f067e365@xenomai.org>
 <a1a45f96-cc5b-22c5-0414-da41ebee6f96@oss-tech.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <a1dfb17a-e8e8-19b6-7340-a57e5e321e42@xenomai.org>
Date: Wed, 22 Nov 2017 17:23:53 +0100
MIME-Version: 1.0
In-Reply-To: <a1a45f96-cc5b-22c5-0414-da41ebee6f96@oss-tech.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [RFC] RTnet, Analogy and the elephant in the room
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Dmitriy Cherkasov <dmitriy@oss-tech.org>, xenomai@xenomai.org

On 11/21/2017 08:54 PM, Dmitriy Cherkasov wrote:
> On 11/21/2017 09:11 AM, Philippe Gerum wrote:
> 
>> So, let's talk about the elephant in the room: the current situation of
>> the Xenomai project is not viable in the long run. I can only encourage
>> people who feel concerned about it to discuss openly the practical steps
>> to best address this challenge.
> 
> Hi Philippe,
> 
> I would be happy to help any way that I can, especially with any of the
> new pipeline work.
> 
We may want to discuss this in a separate thread if interested, however
some context may fit here:

linux-steely (master branch) as visible on the git server contains the
current state of this work, tracking the mainline tip as closely as
possible (up to commit #83bfd83650cc, anything on top is a new co-kernel
derived from Cobalt I'm toying with for experimenting with the pipeline
and new ideas for a better integration in Linux).

The development took place on imx6qp and imx7d so far; I want to port
this to aarch64 and started to do so. imx can run the basic tests, the
aarch64 port does not boot yet. The whole thing is still very much in a
state of flux, as better ways to make dual kernel support a basic Linux
feature - instead of a set of unrelated sideways - appear.

A reasonable plan would be to interface Xenomai's Cobalt core with the
new pipeline at some point, while keeping the I-pipe option available,
gradually phasing out the current I-pipe generation as the new one matures.

> Having said that, I think this is a good discussion to have. If there
> are commercial or institutional users of any of the somewhat neglected
> subsystems, this would be a good time to remind them to invest some
> resources into maintaining these things in the upstream project.
> 

Feedback and proposals for even simple changes which may help users in
the future are valuable contributions too, which come at virtually no
cost. Once a problem is stated, resources to fix it may be looked for.

> I think in general, hobbyist contributors will mostly work on what they
> find interesting to themselves, and if there is no hobbyist or
> commercial support for certain features then perhaps it does make sense
> to drop them.
> 
Ack. At any rate, shipping bit rot software people would unfortunately
rely upon never helped anyone.

-- 
Philippe.

