Message-ID: <54C760BC.7040301@colgp.it>
Date: Tue, 27 Jan 2015 10:56:12 +0100
From: Luca Galvagno <luca.galvagno@colgp.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Linux scheduling is hijacked from xenomai scheduling
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi to all,
we are using kernel 2.6.34 with the corresponding ADEOS patch 
(2.6.34-powerpc-2.10-03.patch ) and Xenomai on a PowerPC MPC5200b.
We are facing on a strange behavior when mixing Linux SysCalls with 
Xenomai tasks . The effect of the above mix is that the "pure" (without 
linux syscall) xenomai task continues to run , the remaining "mixed" 
task (for example we have one with a posix socket server) and moreover 
the linux os itself are not scheduled anymore. Specifically, to test 
this behavior, we connected an oscilloscope to a cpu pin , the result is 
that the xenomai task is moving the pin up and down (as it was 
programmed) but the linux machine is neither accessible via ping or via SSH.

Do you have some suggestions, or some tests we can do ?
Thanks
Regards

-- 
Luca Galvagno


