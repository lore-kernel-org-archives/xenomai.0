From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Subject: smokey arm64 gdb tests
Message-ID: <4d2b41d6-2b78-5d49-6ddb-94741eab6e3a@siemens.com>
Date: Wed, 2 Oct 2019 10:37:04 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I did a run of smokey on arm64 and it aborts in the gdb test with the 
error:
FAILURE run_gdb:287: checking expression \"primary_mode\", expected 
\"1\", found \"0\"


My question should the gdb test run on arm64?
If not we should exclude it for the time being.

Thanks,
Quirin

-- 
Quirin Gylstorff

Siemens AG
Corporate Technology
CT RDA IOT SES-DE


