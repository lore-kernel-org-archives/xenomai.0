Date: Tue, 16 May 2017 13:41:32 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20170516134132.3373e4a8@md1em3qc>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] linking problems on Ubuntu
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Hi,

i have been seeing occasional linking problems with 3.0.4 and Ubuntu
16.04. The root cause of the problem is that the ubuntu toolchain
defaults to linking with "--as-needed" while most other toolchains seem
to default to "--no-as-needed".
Depending on your program the linker might not recognize that some
libraries are actually needed, because they are just pulled in by weak
symbols. Inspecting the binary or .so with ldd will show that not all of
the libs you specified actually made it in.

I will have to investigate further on how best to solve that.
xeno-config could emit -Wl,--no-as-needed before -l.. but we can not
really finish with "-Wl,--as-needed" because we don't know the
toolchains default.

The weak symbols and wrapping code depends on "--no-as-needed", for a
sane toolchain there is no need to be explicit about that. These morons
did not even bother changing the manpages as well ...

So i guess it should be made explicit. I will probably write a patch to
xeno-config to just add --no-as-needed regardless. It might have to go
into the build-system as well. Any objections or ideas how to address
that differently?

Henning

