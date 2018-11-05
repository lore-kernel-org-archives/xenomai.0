From: limingyu <myli@linx-info.com>
Subject: [e1000e porting] Unable to send one frame?
Message-ID: <9f67b1f1-4de9-5943-30dd-3db64e842665@linx-info.com>
Date: Mon, 5 Nov 2018 10:43:49 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I‘m recently work with Xenomai and RTnet,

and I found that rt_e1000e driver didn't goes

well with the my computer(As my computer

uses I219-V2 Ethernet adapter), so I just try to

work it out.

I use the linux-4.9.51 as my kernel, and ported the

intel e1000e driver to the RTnet now. And I have

already make it able to send the SYNC frame of

TDMA  and Stage 1 Config frame of RTcfg now in

the QEMU emulator. But I just found that it's unable

to send the Calibration frame back to master from

slave side as it's just ONE frame. I can send large

number of frame like SYNC and stage 1 frame but

can't send just one frame!

Does anybody have any idea of this situation?

-- 
北京凝思软件股份有限公司四川分公司
联系人：李明宇
联系电话：028-65182023-6202
E-mail: myli@linx-info.com
公司地址：成都市武侯区天府大道中段530东方希望天祥广场1号楼3402


