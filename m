References: <abf31608-ffa8-17e0-e3eb-4d62f067e365@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <1b035acc-5784-f0b0-f16f-09279d5a8845@siemens.com>
Date: Wed, 22 Nov 2017 21:26:23 +0100
MIME-Version: 1.0
In-Reply-To: <abf31608-ffa8-17e0-e3eb-4d62f067e365@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>
Cc: Daniel Wagner <daniel.wagner@siemens.com>

On 2017-11-21 18:11, Philippe Gerum wrote:
> So, let's talk about the elephant in the room: the current situation of
> the Xenomai project is not viable in the long run. I can only encourage
> people who feel concerned about it to discuss openly the practical steps
> to best address this challenge.

Thanks for bringing this frankly on the table! For those who follow the
project, it's likely no news. So we were working on this issue also
internally, with users of Xenomai inside Siemens. And we have the
backing to enhance our involvement in upstream work. Right now we are
working on making this concrete.

There are many areas where contributions can be beneficial for the
project and its community, and many do not require deepest understanding
of the core, like around CI, test automation, distro packaging,
documentation, or user support. But some essential elements in my eyes are

 - building up a core team of kernel maintainers for Cobalt

 - offloading work from the shoulders of our extremely valuable
   maintainer

The second part will be achieved to a certain degree by the first one as
Philippe can probably confirm. So I would like to focus this and try to
make some first step:

We are currently planning a so far internal workshop with Philippe in
order to discuss how to bring more of our people but also others on
board regarding kernel maintenance topics. Topics to discussed are likely

 - current design and how to introduce people to it (tough, yeah...)
 - possible workflows and integration paths
 - update strategy and frequency
 - testing needs and strategies
 - supportable architectures
 - state and details of the new pipeline design
 - planning of and migration path to the new design

If there is interest in joining such a discussion, physically (will
likely take place in our office in Munich, Germany) or virtually
(provided time zones work out), please let us know. Time frame is more
likely early next year than mid of this December. And this shall be only
the kickoff for further discussions in the community!

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

