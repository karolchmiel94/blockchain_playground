import { artifacts, ethers, waffle } from "hardhat";
import type { Artifact } from "hardhat/types";
import type { SignerWithAddress } from "@nomiclabs/hardhat-ethers/dist/src/signer-with-address";

import type { Election } from "../../src/types/Election";
import { Signers } from "../types";
import { shouldBehaveLikeElection } from "./Election.behavior";

describe("Unit tests", function () {
  before(async function () {
    this.signers = {} as Signers;

    const singers: SignerWithAddress[] = await ethers.getSigners();
    this.signers.admin = singers[0];
  });

  describe("Election", function () {
    before(async function () {
      const now = Date.now();
      const elections: any[] = [["Tom Harry", "Anna Smith", "Johny White", "Sara Bonnet"], now, now + 3600];
      const electionArtifact: Artifact = await artifacts.readArtifact("Election");
      this.election = <Election>await waffle.deployContract(this.signers.admin, electionArtifact, elections);
    });

    shouldBehaveLikeElection();
  });
});
