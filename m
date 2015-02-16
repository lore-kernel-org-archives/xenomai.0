Message-ID: <54E24FED.8050906@mperpetuo.com>
Date: Mon, 16 Feb 2015 12:15:41 -0800
From: Gary Gitelson <gary@mperpetuo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] ARMv8 (ARM64) port of Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

     There is an excellent guide for porting Xenomai to other ARM-based 
SOCs.  But this seems to assume that they are 32-bit ARM SOCs, based on 
ARMv7 or lower.  Is there active work, or a guide or assistance, on 
porting to SOCs based on ARMv8 architectures (specifically, in my case, 
the Qualcomm MSM8994).  I assume that almost everything in the arch/arm 
portion of the kernel would need to exist in the arch/arm64 subtree, but 
I am not sure exactly what is involved here.
     Any assistance, or leads on existing work, would be much appreciated.

Thanks,
Gary


