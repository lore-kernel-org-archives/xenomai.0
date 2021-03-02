Date: Tue, 02 Mar 2021 20:43:03 -0300
From: Gabriel Dinse <gabriel_dinse@hotmail.com>
Subject: Cannot disable Page migration on kernel configuration
Message-ID: <SN6PR08MB5661FBDD5171C06547422CD293999@SN6PR08MB5661.namprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

When configuring kernel (4.19.144 arm) through menuconfig, I get the 
following warning:
[*] Xenomai/cobalt  --->
*** WARNING! Page migration (CONFIG_MIGRATION) may increase ***
*** latency. ***

But I'm not able to disable it:
Memory Management options  --->
         -*-   Page migration

Is it possible to do it different than using menuconfig?

Thank you,
Gabriel Dinse

