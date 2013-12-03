MIME-Version: 1.0 (Apple Message framework v1283)
From: Kurijn Buys <Kurijn.Buys@open.ac.uk>
In-Reply-To: <529DCF2F.1070702@xenomai.org>
Date: Tue, 3 Dec 2013 13:07:26 +0000
Message-ID: <1507DF58-4A8D-42E0-92B8-4A9EAB4289E3@open.ac.uk>
References: <40A5BE95-8E78-4CD6-81D2-C97AA7A58FBB@open.ac.uk>
 <529DCF2F.1070702@xenomai.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] latency spikes under load
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai@xenomai.org

Thanks for the quick response,
ACPI is enabled, I only disabled "Processor" in there...
-1 was a typo indeed, it is at 1...
I see SCHED_SMT [=3Dy] in my kernel config... shall I recompile the kernel =
with this disabled then... no other things to try first/at the same time?

I realized that the test with sched_rt_runtime_us on -1 I performed was wit=
h an earlier set-up. When I set it now to -1, I have better performance, bu=
t:
1) still spikes of up to 87us under load with ./latency
2) still some completely shifted occurrences with the other latency test, w=
ith a 1000=B5s period (but now only 2 out of 890814), and the rest of the d=
istribution lies in [861-1139]=B5s, which is also rather large I suppose.

The ipipe trace after test (1) was similar to the one I posted, where this =
line seems to be the problem I suppose:
:|   #end     0x80000001  -179! 149.235  ipipe_check_context+0x87 (add_pree=
mpt_count+0x15)

Merci!
]{urijn

Op 3-dec.-2013, om 12:31 heeft Gilles Chanteperdrix het volgende geschreven=
:

On 12/03/2013 12:38 PM, Kurijn Buys wrote:
Hardware: Pentium IV (lspci: 3,2GHz, i686, 32,64bit, 2 cpu's), 2Gb
RAM Software: Ubuntu 10.04, kernel&patch 2.6.38.8, Xenomai 2.6.3

2.6.38 is rather old, could you try a more recent kernel like 3.8.13 to
see if you get the same problem?

I tried with 3.8.13 first, but with the same results.
As I found on the internet that it is not advised to run a too new kernel w=
ith an older ubuntu release I switched to 2.6.38, which is close to the ori=
ginal ubuntu 10.04 one: 2.6.32...

-I've set the SMI workaround by adding "xeno_hal.smi=3D-1" on the
kernel command line
(http://www.xenomai.org/documentation/xenomai-2.6/html/TROUBLESHOOTING/inde=
x.html#SMI),
but maybe it makes a difference when it is set in the kernel config,
as proposed here
(http://www.xenomai.org/index.php/Configuring_x86_kernels), by
setting the CONFIG_XENO_HW_SMI_WORKAROUND variable. However, I didn't
find this variable in my kernel configuration...

Yes, the SMI workaround has changed from a compile-time option to a
run-time option, in order to avoid having to recompile the kernel to
change the option.

--
                                                               Gilles.

-- The Open University is incorporated by Royal Charter (RC 000391), an exe=
mpt charity in England & Wales and a charity registered in Scotland (SC 038=
302).
