// Copyright Epic Games, Inc. All Rights Reserved.

using UnrealBuildTool;

public class StormyGame : ModuleRules
{
	public StormyGame(ReadOnlyTargetRules Target) : base(Target)
	{
		PCHUsage = PCHUsageMode.UseExplicitOrSharedPCHs;

		PublicDependencyModuleNames.AddRange(new string[] { "Core", "CoreUObject", "Engine", "InputCore", "EnhancedInput" });
	}
}
