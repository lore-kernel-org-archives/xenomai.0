Message-ID: <556830E2.1070404@zultron.com>
Date: Fri, 29 May 2015 04:26:58 -0500
From: John Morris <john@zultron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] please review: 3.16.7 kernel .config
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I have a set of 3.16.7 kernel and 3.0-rc4 Xenomai .debs that pass 
`xeno-test`.  Further testing still needed.

The kernel .config 'override' file [1] has been updated with some of the 
3.0 docs, but it's obviously getting crusty.  I'd appreciate a quick look.

[1]: 
https://github.com/zultron/linux-ipipe-deb/blob/3.16.7/config/featureset-xenomai.x86/config

Will a 3.18 patch be distributed with the Xenomai-3 GA release?  I'm 
hoping to also ship RT_PREEMPT kernels based out of the same packaging, 
but there's no 3.16 patch.  Not important, just curious.

	John

