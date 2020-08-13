From: luca <alex_luca@163.com>
Subject: netperf components will significantly increase interrupt latency
Message-ID: <7bbc7aaa-7ed4-b807-665a-5fa1c34f964c@163.com>
Date: Thu, 13 Aug 2020 23:03:11 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

A strange phenomenon happened to me recently: 
I found that the netperf(I use v2.7.0) will impact the results of 
*latency -t2* testcase.
The latency gets worse and worse with the running-number grows of
netperf. More than 15us *max latency* got than off load when
4*netperfs running on my machine at once.

My machine:sun8iw11p1-soc,  4-cores
Soft ware: xenomai-3.1, ipipe-core-4.14.85-arm-6.patch  

Anybody come across this situation before?

Thanks.




