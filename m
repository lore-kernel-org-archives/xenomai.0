Subject: Re: smokey's fork tests hangs with glibc 2.28+ ?
References: <c57ea289db8a425da4d09d89d0de5d96@andritz.com>
 <76f0e9a2-f783-df4f-d736-4f0e246d44c2@siemens.com>
 <f6c647a090744868b23a138ad213e96c@andritz.com>
 <b9e0b39a-e3e9-f99e-eb44-a1e8ddf34aae@xenomai.org>
 <3ecf3b2ce17f4bc8acf34e668eb26171@andritz.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <ced8776f-4d59-726b-171e-608d35453508@xenomai.org>
Date: Tue, 12 Mar 2019 09:15:25 +0100
MIME-Version: 1.0
In-Reply-To: <3ecf3b2ce17f4bc8acf34e668eb26171@andritz.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lange Norbert <norbert.lange@andritz.com>, Jan Kiszka <jan.kiszka@siemens.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 3/11/19 3:41 PM, Lange Norbert wrote:
> Thanks Phillipe,
> 
> assume just for a moment that I know little of the issues,
> is there any harm using glibc 2.28 for now, given that I don’t
> run into those deadlocks or could there be some more
> subtile breakage involved?

I don't know. This said, this question includes its own answer: 2.28 is
a recent release which few people have already used in a Xenomai
context, so any obvious bug we did not find yet might look subtle at
first glance.

-- 
Philippe.

