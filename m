Message-ID: <9c81a634-df9c-5622-9c6b-56f19a8e13d4@siemens.com>
Date: Wed, 13 Oct 2021 09:51:05 +0200
Subject: Re: [xenomai-images][PATCH 6/6] ci: Fail test job when an error
 occurred during lava job submission
Content-Language: en-US
References: <20211013071824.9394-1-florian.bezdeka@siemens.com>
 <20211013071824.9394-7-florian.bezdeka@siemens.com>
 <414d5235-e971-dbc6-1cb2-06c5f805d20a@siemens.com>
From: Florian Bezdeka <florian.bezdeka@siemens.com>
In-Reply-To: <414d5235-e971-dbc6-1cb2-06c5f805d20a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org, Quirin Gylstorff <quirin.gylstorff@siemens.com>

On 13.10.21 09:28, Jan Kiszka wrote:
> On 13.10.21 09:18, Florian Bezdeka via Xenomai wrote:
>> It can happen that the LAVA job submission fails. If so, the CI job
>> should be marked as failed. Previously we had something like the
>> following in the log, but the job was still marked as "OK".
>>
>> Log:
>> connect to lava server: https://lava.xenomai.org
>> Deploy artifacts from 'https://xenomai-images-artifacts.s3.amazonaws.com/artifacts'
>> submit lava job
>> <ProtocolError for https://[snip]/RPC2: 500 HTTPSConnectionPool(host='lava.xenomai.org', port=443): Read timed out. (read timeout=20.0)>
>> <ProtocolError for https://[snip]/RPC2: 500 HTTPSConnectionPool(host='lava.xenomai.org', port=443): Read timed out. (read timeout=20.0)>
>> scripts/run-lava-tests.sh: 56: [: Illegal number:
>>
>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>> ---
>>  scripts/run-lava-tests.sh | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
>> index dde542c..de63b28 100755
>> --- a/scripts/run-lava-tests.sh
>> +++ b/scripts/run-lava-tests.sh
>> @@ -9,6 +9,7 @@
>>  #
>>  # SPDX-License-Identifier: MIT
>>  #
>> +set -e
>>  TARGET=$1
>>  if [ -z "${TARGET}" ]; then
>>      echo "no target was given"
>>
> 
> Is this resolving what we saw with lava.xenomai.org being down?

Yes. See cover letter ;-)

> 
> Jan
> 


-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

