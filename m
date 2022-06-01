Message-ID: <9d47b5f3-b18e-0f75-9753-fefec5e9bdd7@siemens.com>
Date: Wed, 1 Jun 2022 07:50:37 +0200
MIME-Version: 1.0
Subject: Re: [RFC] Rust API for evl
Content-Language: en-US
References: <87mtexkcxf.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <87mtexkcxf.fsf@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 31.05.22 15:37, Philippe Gerum via Xenomai wrote:
> 
> I've been getting my feet wet with Rust for a few weeks now, assessing
> the real-time latency figures I could get from an existing (C++)
> application once fully rewritten in this language.  It turned out that
> performance was on par with the original implementation with memory
> safety on top, among other upsides (like having quite some fun coding in
> Rust in the first place).
> 
> Having Rust as a Tier 1 language for Xenomai4/evl along with the
> existing C interface definitely makes sense to me. The goal would be to
> have a 'revl' interface providing the EVL services the idiomatic Rust
> way, available as a crate on top of the FFI bindings to libevl which
> have just landed [1].
> 
> Whether you are a Rustacean or not, if you are willing to discuss and
> help with this, let me know.
> 
> [1] https://source.denx.de/Xenomai/xenomai4/evl-sys.git
> 

I think this is a very interesting experiment, and I'm excited to see
that there are apparently no RT traps in the runtime. Do you have some
example code somewhere as well?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

